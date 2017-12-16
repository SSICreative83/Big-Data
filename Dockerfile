FROM jupyter/minimal-notebook

MAINTAINER Pierre Navaro <pierre.navaro@univ-rennes1.fr>

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends default-jdk python-software-properties ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/hadoop_store/hdfs/namenode && \
    mkdir -p /opt/hadoop_store/hdfs/datanode && \
    chown -R $NB_USER /opt/hadoop_store      && \
    fix-permissions /opt/hadoop_store
    
# hadoop
RUN curl -s http://apache.crihan.fr/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.9.0 hadoop

ENV HADOOP_PREFIX /usr/local/hadoop

RUN chown $NB_USER $HADOOP_PREFIX && \
    fix-permissions $HADOOP_PREFIX

ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

USER $NB_USER

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
    'fastparquet' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

RUN pip install --no-cache-dir \
    toyplot \
    && \
    fix-permissions $CONDA_DIR
