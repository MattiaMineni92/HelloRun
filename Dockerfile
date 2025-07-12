FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia solo il .csproj per il restore
COPY ./HelloRun.API/HelloRun.API/HelloRun.API.csproj ./HelloRun.API/
RUN dotnet restore ./HelloRun.API/HelloRun.API.csproj

# Copia tutto il progetto e compila
COPY . ./
RUN dotnet publish ./HelloRun.API/HelloRun.API.csproj -c Release -o /app/publish

# Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "HelloRun.API.dll"]
