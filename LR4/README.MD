# ЛР 4
## Задание - задеплоить какой-нибудь сервис на кластере k8s

Занимаемся чисто FastApi

docker build -t fastapi-app:latest .

k3d image import fastapi-app:latest -c mycluster 

kubectl apply -f k8s/deployment.yaml

Поды подняты, сервис вроде работает

https://github.com/ShadowCatLul/docker-kuber/blob/main/sources/Picture6.png
