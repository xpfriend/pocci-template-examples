FROM htdvisser/taiga-front-dist:stable
RUN sed 's/^{$/{"loginFormType": "ldap",/' -i /usr/local/taiga/configure
