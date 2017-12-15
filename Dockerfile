FROM rocker/binder:3.4.2

# Copy repo into ${HOME}, make user own $HOME
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    default-jdk \
    ssh \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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
