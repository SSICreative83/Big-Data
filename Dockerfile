FROM jupyter/minimal-notebook

MAINTAINER Pierre Navaro <pierre.navaro@univ-rennes1.fr>

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends default-jdk python-software-properties ssh curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/hadoop_store/hdfs/namenode && \
    mkdir -p /opt/hadoop_store/hdfs/datanode && \
    chown -R $NB_USER /opt/hadoop_store      && \
    fix-permissions /opt/hadoop_store && \
    curl -s http://apache.crihan.fr/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz | tar -xz -C /usr/local/ && \
    cd /usr/local && ln -s ./hadoop-2.9.0 hadoop 
    
COPY hadoop/* /tmp/

RUN mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml && \
    chmod +x /usr/local/hadoop/sbin/start-dfs.sh && \
    chmod +x /usr/local/hadoop/sbin/start-yarn.sh && \
    chown -R $NB_USER /usr/local/hadoop && \
    fix-permissions /usr/local/hadoop

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

USER $NB_USER

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
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    /usr/local/hadoop/bin/hdfs namenode -format && \
    $HADOOP_HOME/sbin/start-dfs.sh && \
    $HADOOP_HOME/sbin/start-yarn.sh 
    
# conda-forge packages
RUN conda install --quiet --yes -c conda-forge \
    'lorem' \
    'dask' \
    'pandas' \
    'pytables' \
    'pandas' \
    'lorem' \
    'joblib' \
    'ujson' \
    'dask' \
    'pytables' \
    'pyspark' \
    'graphviz' \
    'python-graphviz' \
    'beautifulsoup4' \
    'toolz' \
    'h5py' \
    'partd' \
    'matplotlib' \
    'seaborn' \
    'hdfs3' \
    'progressbar2' \
    'pyarrow' \
    'feather-format' \
    'fastparquet' \
    'distributed' \
    'xlwt' \
    'fastparquet' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

RUN pip install --no-cache-dir \
    toyplot \
    && \
    fix-permissions $CONDA_DIR
