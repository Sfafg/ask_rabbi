using AutoMapper;
using backend.Models;

public class QuestionProfile : Profile
{
    public QuestionProfile()
    {
        CreateMap<PostQuestionDto, Question>();
        CreateMap<Question, QuestionDto>();
    }
}
