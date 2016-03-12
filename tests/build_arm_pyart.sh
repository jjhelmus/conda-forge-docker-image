echo "
channels:
 - conda-forge
 - defaults # As we need conda-build
conda-build:
 root-dir: /feedstock_root/build_artefacts
show_channel_urls: True
""" > ~/.condarc

conda clean --lock
conda info

export CONDA_NPY=110
export CONDA_PY=27
conda build /tests/arm_pyart --quiet

export CONDA_NPY=19
export CONDA_PY=27
conda build /tests/arm_pyart --quiet

export CONDA_NPY=110
export CONDA_PY=34
conda build /tests/arm_pyart --quiet

export CONDA_NPY=19
export CONDA_PY=34
conda build /tests/arm_pyart --quiet

export CONDA_NPY=110
export CONDA_PY=35
conda build /tests/arm_pyart --quiet

export CONDA_NPY=19
export CONDA_PY=35
conda build /tests/arm_pyart --quiet
