require 'houston'

pem = ARGV.shift
token = ARGV.shift
sec = ARGV.shift
desc = ARGV.shift

unless pem && token && sec && desc
  STDERR.puts('invalid arguments')
  exit(1)
end

unless File.exist?(pem)
  STDERR.puts("#{pem} not found")
  exit(1)
end

unless File.exist?(token)
  STDERR.puts("#{token} not found")
  exit(1)
end

APN = Houston::Client.development
APN.certificate = File.read(pem)
token = File.read(token).chomp

sleep(sec.to_i)

notification = Houston::Notification.new(device: token)
notification.alert = "#{desc} timeout"
notification.badge = 0
notification.sound = 'dummy'

APN.push(notification)
