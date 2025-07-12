# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY HelloRun.API/HelloRun.API.csproj HelloRun.API/
RUN dotnet restore HelloRun.API/HelloRun.API.csproj

COPY . ./
RUN dotnet publish HelloRun.API/HelloRun.API.csproj -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "HelloRun.API.dll"]
