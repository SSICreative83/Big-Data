import os
import subprocess
import tempfile

import nbformat

def _notebook_run(path,nb_file):
    """Execute a notebook via nbconvert and collect output.
       :returns (parsed nb object, execution errors)
    """
    os.chdir(path)
    with tempfile.NamedTemporaryFile(suffix=".ipynb") as fout:
        args = ["jupyter", "nbconvert", "--to", "notebook", "--execute",
          "--ExecutePreprocessor.timeout=60",
          "--output", fout.name, nb_file]
        subprocess.check_call(args)

        fout.seek(0)
        nb = nbformat.read(fout, nbformat.current_nbformat)

    errors = [output for cell in nb.cells if "outputs" in cell
                     for output in cell["outputs"]\
                     if output.output_type == "error"]
    os.chdir('..')

    return nb, errors

def test_ipynb_2017_01():
    here = os.getcwd()
    nb, errors = _notebook_run(os.path.join(here,'2017'),'01.MapReduce.ipynb')
    assert errors == []

def test_ipynb_2017_02():
    here = os.getcwd()
    nb, errors = _notebook_run(os.path.join(here,'2017'),'02.Containers.ipynb')
    assert errors == []

def test_ipynb_2017_03():
    here = os.getcwd()
    nb, errors = _notebook_run(os.path.join(here,'2017'),'03.ParallelComputation.ipynb')
    assert errors == []

def test_ipynb_2017_04():
    here = os.getcwd()
    nb, errors = _notebook_run(os.path.join(here,'2017'),'04.AsynchronousProcessing.ipynb')
    assert errors == []    