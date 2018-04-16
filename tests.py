import os
import subprocess
import tempfile
import nbformat
import sys
from pathlib import Path
import nbconvert
from nbconvert.preprocessors import ExecutePreprocessor
import glob

print("Running Notebooks...")

os.chdir('notebooks')

def _notebook_run(nb_file):

    """Execute a notebook via nbconvert and collect output.
       :returns (parsed nb object, execution errors)
    """

    with tempfile.NamedTemporaryFile(suffix=".ipynb") as fout:
        args = ["jupyter", "nbconvert", "--to", "notebook", "--execute",
          "--ExecutePreprocessor.timeout=500",
          "--output", fout.name, nb_file]
        subprocess.check_call(args)

        fout.seek(0)
        nb = nbformat.read(fout, nbformat.current_nbformat)

    errors = [output for cell in nb.cells if "outputs" in cell
                     for output in cell["outputs"]\
                     if output.output_type == "error"]
    return nb, errors

def test_ipynb_01():
    here = os.getcwd()
    nb, errors = _notebook_run('01.MapReduce.ipynb')
    assert errors == []

def test_ipynb_02():
    here = os.getcwd()
    nb, errors = _notebook_run('02.Containers.ipynb')
    assert errors == []

def test_ipynb_03():
    here = os.getcwd()
    nb, errors = _notebook_run('03.ParallelComputation.ipynb')
    assert errors == []

def test_ipynb_04():
    here = os.getcwd()
    nb, errors = _notebook_run('04.AsynchronousProcessing.ipynb')
    assert errors == []
    
def test_ipynb_05():
    here = os.getcwd()
    nb, errors = _notebook_run('05.UnixCommands.ipynb')
    assert errors == []

#def test_ipynb_06():
#    here = os.getcwd()
#    nb, errors = _notebook_run('06.Hadoop.ipynb')
#    assert errors == []
#
#def test_ipynb_07():
#    here = os.getcwd()
#    nb, errors = _notebook_run('07.PySpark.ipynb')
#    assert errors == []
#
#def test_ipynb_08():
#    here = os.getcwd()
#    nb, errors = _notebook_run('08.Dask.ipynb')
#    assert errors == []
#
#def test_ipynb_09():
#    here = os.getcwd()
#    nb, errors = _notebook_run('09.PandasSeries.ipynb')
#    assert errors == []
#
#def test_ipynb_10():
#    here = os.getcwd()
#    nb, errors = _notebook_run('10.DaskDataframes.ipynb')
#    assert errors == []
#
#def test_ipynb_11():
#    here = os.getcwd()
#    nb, errors = _notebook_run('11.PySparkHadoop.ipynb')
#    assert errors == []
#
#def test_ipynb_12():
#    here = os.getcwd()
#    nb, errors = _notebook_run('12.NYCTaxiCabTrip.ipynb')
#    assert errors == []
#
#def test_ipynb_13():
#    here = os.getcwd()
#    nb, errors = _notebook_run('13.ExamCorrection.ipynb')
#    assert errors == []
