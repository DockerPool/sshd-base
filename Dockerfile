#���ü̳о���
FROM ubuntu:14.04
#�ṩһЩ���ߵ���Ϣ
MAINTAINER Waitfish from Dockerpool (dwj_zz@163.com)
#���濪ʼ��������,�˴�����ubuntu��ԴΪ����163��Դ
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update
#����ϵͳʱ��
RUN echo "Asia/Shanghai" > /etc/timezone && \
                dpkg-reconfigure -f noninteractive tzdata
#ע������Ҫ����ϵͳ��ʱ�����ã���Ϊ�� web Ӧ���о������õ�ʱ�����ϵͳ������Ĭ�ϵ� ubuntu �������Ӧ�ó���������˼���Ч��Ŷ


#��װ ssh ����
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
#ȡ��pam����
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

#���������ļ�����Ӧλ��,������ű���ִ��Ȩ��
ADD authorized_keys /root/.ssh/authorized_keys
ADD run.sh /run.sh
RUN chmod 755 /run.sh

#���Ŷ˿�
EXPOSE 22

#��������������
CMD ["/run.sh"]
