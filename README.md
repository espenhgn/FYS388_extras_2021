# FYS388_extras_2021
Some files for FYS388 FYS488 at NMBU 2021


# Creating images (virtual machines) using Docker

Some tools needed for the course exercises are not so straightforward to set up on e.g., Windows.
But they can be used by creating a virtual Linux installation running via Docker (https://www.docker.com).
So start by installing the Docker client on your computer.

Then you can


## NEURON/LFPY docker image for exercises

After installing Docker,
then you can create a Docker image with a Python installation that works with the exercises by issuing in the terminal/command line:

    docker build -t fys388 https://raw.githubusercontent.com/espenhgn/FYS388_extras_2021/main/Dockerfile


Setting up the image may take a little while.
Afterward building it, you may run it by issuing:

    docker run -it -p 5000:5000 fys388


The ``--mount`` option can be used to mount a folder on the host (like one with exercise notebooks) to a target folder as:

    docker run --mount type=bind,source="$(pwd)",target=/opt -it -p 5000:5000 fys388


which mounts the present working dirctory (``$(pwd)``) to the ``/opt`` directory of the container.
Try mounting a  source directory  with exercise notebooks (by setting ``source="<path-to-exercises>"``).
Various files can then be found in the folder ``/opt/<exercises>``
when the container is running.

Jupyter notebook servers running from within the
container can be accessed after invoking them by issuing:

    $ cd /opt/
    $ jupyter notebook --ip 0.0.0.0 --port=5000 --no-browser --allow-root


and opening the resulting URL in a browser on the host computer, similar to:
http://127.0.0.1:5000/?token=a2acca08271c33f720f2b88a2328f5be083590fb4aa85816


## NEST Desktop

This should be straightforward.
Follow the instructions at:
https://nest-desktop.readthedocs.io/en/stable/user/setup.html#via-docker-compose-linux-windows-apple
