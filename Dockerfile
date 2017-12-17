FROM jupyter/minimal-notebook

MAINTAINER Pierre Navaro <pierre.navaro@univ-rennes1.fr>

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends default-jdk python-software-properties ssh curl sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/hadoop_store/hdfs/namenode && \
    mkdir -p /opt/hadoop_store/hdfs/datanode && \
    fix-permissions /opt/hadoop_store && \
    curl -s http://apache.crihan.fr/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz | tar -xz -C /usr/local/ && \
    cd /usr/local && ln -s ./hadoop-2.9.0 hadoop
    
COPY hadoop/* /tmp/

RUN mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml && \
    chmod +x /usr/local/hadoop/sbin/start-dfs.sh && \
    chmod +x /usr/local/hadoop/sbin/start-yarn.sh && \
    fix-permissions /usr/local/hadoop

EXPOSE 9000 50010 50020 50070 50075 50090
EXPOSE 19888 8030 8031 8032 8033 8040 8042 8088
EXPOSE 49707 2122 22
RUN /etc/init.d/ssh start

COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 

# ssh without key
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -P '' && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

ADD hadoop/ssh_config /root/.ssh/config
RUN sed s/HOSTNAME/$HOSTNAME/ hadoop/core-site.xml > /usr/local/hadoop/etc/hadoop/core-site.xml
RUN service ssh start && /usr/local/hadoop/bin/hdfs namenode -format && \
    $HADOOP_HOME/sbin/start-dfs.sh && \
    $HADOOP_HOME/sbin/start-yarn.sh 

# conda-forge packages
RUN conda install --quiet --yes -c conda-forge \
    'lorem' 'dask' 'pandas' 'pytables' 'pandas' \
    'joblib' 'ujson' 'pyspark' \
    'graphviz' 'python-graphviz' 'beautifulsoup4' \
    'toolz' 'h5py' 'partd' 'matplotlib' 'seaborn' \
    'hdfs3' 'progressbar2' 'pyarrow' \
    'feather-format' 'fastparquet' 'distributed' \
    'xlwt' 'fastparquet' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

RUN pip install --no-cache-dir toyplot && \
    fix-permissions $CONDA_DIR
