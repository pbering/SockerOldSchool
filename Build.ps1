$tag = "sitecore:4.3.2.13.0"
$name = "sc432"

docker rm --force $name

docker build --tag $tag .

if($LASTEXITCODE -eq 0)
{
    docker run -d --name $name -p "9999:80" $tag
} 