using AutoMapper;
using backend.Models;

public class UserProfile : Profile
{
    public UserProfile()
    {
        CreateMap<RegisterDto, User>();
        CreateMap<User, UserSummaryDto>();
    }
}
