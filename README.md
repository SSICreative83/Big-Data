# big-data
Notebooks for Master of Data Science Rennes 

[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/pnavaro/big-data/master)

## Run Jupyter notebooks with docker

You can run these notebooks with Docker. The following command starts a container with the Notebook 
server listening for HTTP connections on port 8888 without authentication configured.

```
git clone https://github.com/pnavaro/big-data.git
docker run -d -v $HOME/big-data:/home/jovyan/ -p 8888:8888 pnavaro/big-data
```

## References

### Books
  * [Python for Data Analysis](https://github.com/wesm/pydata-book) by Wes McKinney.
  * [Python Data Science Handbook](https://github.com/jakevdp/PythonDataScienceHandbook) by Jake VanderPlas
  
### Software documentation
  * [Pandas](http://pandas.pydata.org).
  * [Dask](https://dask.pydata.org/)
  * [PySpark](http://spark.apache.org/docs/latest/api/python/index.html)
  * [Apache Arrow](https://arrow.apache.org/docs/python/index.html)
  * [Parquet](https://parquet.apache.org)
  * [GCSFS](http://gcsfs.readthedocs.io/en/latest/)
  * [Dask.distributed](https://distributed.readthedocs.io/en/latest/)
  * [fastparquet](https://fastparquet.readthedocs.io/en/latest/)
  * [hdfs3](http://hdfs3.readthedocs.io/en/latest/)

### Tutorials
  * [Analyzing and Manipulating Data with Pandas Beginner](https://youtu.be/6ohWS7J1hVA): SciPy 2016 Tutorial by Jonathan Rocher.
  * [Parallelizing Scientific Python with Dask](https://youtu.be/mbfsog3e5DA), SciPy 2017 Tutorial by James Crist.
  * [Writing an Hadoop MapReduce Program in Python](http://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/) by Michael G. Noll.
  * [Parallel Data Analysis in Python](https://www.youtube.com/watch?v=a8gpcnmggiU), SciPy 2017 Tutorial by Matthew Rocklin, Ben Zaitlen & Aron Ahmadia.
  * [Parallel Python: Analyzing Large Datasets Intermediate](https://www.youtube.com/watch?v=5Md_sSsN51k), SciPy 2016 Tutorial by Matthew Rocklin.

### Blog posts
  * [Should you replace Hadoop with your laptop?](http://veekaybee.github.io) by Vicki Boykis.
  * [Implementing MapReduce with multiprocessing](https://pymotw.com/2/multiprocessing/mapreduce.html) by Doug Hellmann.


### Online courses
  * [DataCamp Cheat Sheets](https://www.datacamp.com/community/data-science-cheatsheets)
  * [Outils pour le Big Data](https://perso.univ-rennes1.fr/pierre.nerzic/Hadoop/) by Pierre Nerzic. 🇫🇷
  * [wikistat - Ateliers Big Data](https://github.com/wikistat/Ateliers-Big-Data) by Philippe Besse. 🇫🇷



Pierre
