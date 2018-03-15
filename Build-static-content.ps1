# build image
docker build -t static-nginx .

#Get mount 
$v = Read-Host 'volume'
New-Item -ItemType Directory $v\nginx\
New-Item -ItemType Directory $v\nginx\logs\
New-Item -ItemType Directory $v\nginx\root\

Copy-Item -Path .\base-files\*.conf -Destination $v\nginx\
Copy-Item -Path .\base-files\mime.types -Destination $v\nginx\
Copy-Item -Path .\base-files\index.html -Destination $v\nginx\root\

# start container on port 8080 mount some path
docker run --name static-nginx `
-v $v/nginx/nginx.conf:/etc/nginx/nginx.conf `
-v $v/nginx/fastcgi.conf:/etc/nginx/fastcgi.conf `
-v $v/nginx/proxy.conf:/etc/nginx/proxy.conf `
-v $v/nginx/mime.types:/etc/nginx/mime.types `
-v $v/nginx/root:/usr/share/nginx/html `
-v $v/nginx/root/index.html:/usr/share/nginx/html/index.html `
-v $v/nginx/logs:/etc/nginx/logs `
 -d -p 8080:80 static-nginx


 #-v $v/nginx/logs/error.log:/etc/nginx/logs/error.log `
#-v $v/nginx/logs/nginx.pid:/etc/nginx/logs/nginx.pid `
#-v $v/nginx/logs/access.log:/etc/nginx/logs/access.log `
#-v $v/nginx/logs/localhost.access.log:/etc/nginx/logs/localhost.access.log `
#-v $v/nginx/logs/domain2.access.log:/etc/nginx/logs/domain2.access.log `
#-v $v/nginx/logs/big.server.access.log:/etc/nginx/logs/big.server.access.log `