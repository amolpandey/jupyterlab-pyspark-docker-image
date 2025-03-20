FROM ubuntu:22.04

# COPY download/spark-3.4.4-bin-hadoop3.tgz  /opt/
# WORKDIR /opt

RUN apt update && apt install default-jdk -y && apt install python3-pip -y && apt install curl -y

RUN curl -# -o /opt/spark-3.4.4-bin-hadoop3.tgz https://dlcdn.apache.org/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz

RUN tar xzvf /opt/spark-3.4.4-bin-hadoop3.tgz -C /opt/

RUN mv /opt/spark-3.4.4-bin-hadoop3 /opt/spark

RUN mkdir /tmp/spark-events

RUN pip install jupyterlab

ENV SPARK_HOME=/opt/spark
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"
ENV PYSPARK_DRIVER_PYTHON='jupyter'
ENV PYSPARK_DRIVER_PYTHON_OPTS='lab --no-browser --ip=0.0.0.0 --port=8888 --allow-root'

COPY scripts/entrypoint.sh .
COPY notebook/pyspark-demo.ipynb .