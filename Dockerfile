FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ./hellorun.api/hellorun.api.csproj ./hellorun.api/
RUN dotnet restore ./hellorun.api/hellorun.api.csproj

COPY . ./
RUN dotnet publish ./hellorun.api/hellorun.api.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "hellorun.api.dll"]
