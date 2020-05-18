#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "core.docker.dll"]

FROM mcr.microsoft.com/dotnet/core/sdk:2.1-stretch AS build
WORKDIR /src
COPY ["core.docker/core.docker.csproj", "core.docker/"]
RUN dotnet restore "core.docker/core.docker.csproj"
COPY . .
WORKDIR "/src/core.docker"
RUN dotnet build "core.docker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "core.docker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "core.docker.dll"]

