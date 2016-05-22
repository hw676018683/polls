APP_ROOT = '/home/deploy/apps/poll'
pidfile "#{APP_ROOT}/shared/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/shared/tmp/sockets/puma.state"
bind "unix:///#{APP_ROOT}/shared/tmp/sockets/puma.sock"
activate_control_app "unix:///#{APP_ROOT}/shared/tmp/sockets/pumactl.sock"

environment 'production'
daemonize true
workers 1
threads 5,5
preload_app!
