FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY FiapCloudGames.Usuarios.sln ./
COPY src/FiapCloudGames.Usuarios.API/FiapCloudGames.Usuarios.API.csproj src/FiapCloudGames.Usuarios.API/
COPY src/FiapCloudGames.Usuarios.Core/FiapCloudGames.Usuarios.Core.csproj src/FiapCloudGames.Usuarios.Core/
COPY src/FiapCloudGames.Usuarios.Infra/FiapCloudGames.Usuarios.Infra.csproj src/FiapCloudGames.Usuarios.Infra/

RUN dotnet restore src/FiapCloudGames.Usuarios.API/FiapCloudGames.Usuarios.API.csproj

COPY . .

WORKDIR /src/src/FiapCloudGames.Usuarios.API
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 5000
ENTRYPOINT ["dotnet", "FiapCloudGames.Usuarios.API.dll"]
