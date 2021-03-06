FROM jupyter/datascience-notebook:abdb27a6dfbb

#Set the working directory
WORKDIR /home/jovyan/

# Modules
USER root
COPY requirements.txt /home/jovyan/requirements.txt
RUN apt-get update && apt-get -y install graphviz \
    && pip install -r /home/jovyan/requirements.txt

# Add files
COPY notebook/ /home/jovyan/notebook
COPY Data/ /home/jovyan/Data
COPY Slides/ /home/jovyan/Slides
COPY postBuild /home/jovyan/postBuild

# Allow user to write to directory, delete /work, run custom postBuild
USER root
RUN chown -R $NB_USER /home/jovyan && \
    chmod -R 777 /home/jovyan && \
    rm -fR /home/jovyan/work && \
    /home/jovyan/postBuild
USER jovyan

# Expose the notebook port
EXPOSE 8888
