#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM microsoft/dotnet:latest
WORKDIR /app
COPY . /app
EXPOSE 5000/tcp
ENTRYPOINT ["dotnet", "core.docker.dll"]