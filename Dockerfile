#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "core.docker.dll"]

FROM mcr.microsoft.com/dotnet/core/sdk:2.1-stretch AS build
WORKDIR /src
COPY ["AppCoreDocker/AppCoreDocker.csproj", "AppCoreDocker/"]
RUN dotnet restore "AppCoreDocker/AppCoreDocker.csproj"
COPY . .
WORKDIR "/src/AppCoreDocker"
RUN dotnet build "AppCoreDocker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AppCoreDocker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "core.docker.dll"]