#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM microsoft/dotnet:latest
WORKDIR /app
COPY published/AppCoreDocker.dll ./
EXPOSE 5000/tcp
ENTRYPOINT ["dotnet", "AppCoreDocker.dll"]