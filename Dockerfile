FROM conda/miniconda3:latest

WORKDIR /mlflow

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN mkdir -p /mlflow/mlruns \
    && echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh \
    && echo "export LANG=$LANG" >> /etc/profile.d/locale.sh \
    && pip install google-cloud-storage azure-storage pysftp mlflow==1.4.0

COPY run.sh /mlflow/run.sh

EXPOSE 5000

CMD ["/mlflow/run.sh"]
