After JBoss process has started up, manually launch management agent inside it:

# Launch Bash inside Docker container
docker exec -ti #JBoss container ID# bash
# Figure out Java process id
jcmd
# Fire up external management agent
jcmd #Process ID# ManagementAgent.start jmxremote.ssl=false jmxremote.port=7091 jmxremote.rmi.port=7091 jmxremote.authenticate=false jmxremote.autodiscovery=true

# http://hirt.se/blog/?p=388
