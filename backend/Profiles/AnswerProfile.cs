using AutoMapper;
using backend.Models;

public class AnswerProfile : Profile
{
    public AnswerProfile()
    {
        CreateMap<PostAnswerDto, Answer>();
        CreateMap<Answer, AnswerDto>();
    }
}
