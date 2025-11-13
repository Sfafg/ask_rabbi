using Microsoft.EntityFrameworkCore;
using AskRabbiApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
// builder.Services.AddServices();
builder.Services.AddControllers();
builder.Services.AddOpenApi();
builder.Services.AddDbContext<AskRabbiContext>(opt =>
    opt.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

if (app.Environment.IsDevelopment())
    app.MapOpenApi();

// app.UseAuthorization();
app.UseHttpsRedirection();
app.MapControllers();

app.Run();
