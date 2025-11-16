using System;
using System.Collections.Generic;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Data;

public partial class AskRabbiDbContext : DbContext
{
    public AskRabbiDbContext() { }

    public AskRabbiDbContext(DbContextOptions<AskRabbiDbContext> options)
        : base(options) { }

    public virtual DbSet<Answer> Answers { get; set; }

    public virtual DbSet<Question> Questions { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Answer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("answersid");

            entity.ToTable("answers");

            entity.HasIndex(e => e.AnswerId, "one answer").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AnswerId).HasColumnName("answer_id");
            entity.Property(e => e.Body).HasColumnName("body");
            entity.Property(e => e.QuestionId).HasColumnName("question_id");
            entity.Property(e => e.UserId).HasColumnName("user_id");

            entity
                .HasOne(d => d.AnswerNavigation)
                .WithOne(p => p.InverseAnswerNavigation)
                .HasForeignKey<Answer>(d => d.AnswerId)
                .HasConstraintName("answerid");

            entity
                .HasOne(d => d.Question)
                .WithMany(p => p.Answers)
                .HasForeignKey(d => d.QuestionId)
                .HasConstraintName("question");

            entity
                .HasOne(d => d.User)
                .WithMany(p => p.Answers)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("user");
        });

        modelBuilder.Entity<Question>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("id");

            entity.ToTable("questions");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Body).HasMaxLength(1024).HasColumnName("body");
            entity.Property(e => e.UserId).HasColumnName("user_id");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("users_pkey");

            entity.ToTable("users");

            entity.HasIndex(e => e.Email, "users_email_key").IsUnique();

            entity.HasIndex(e => e.Username, "users_username_key").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email).HasMaxLength(100).HasColumnName("email");
            entity.Property(e => e.Password).HasMaxLength(255).HasColumnName("password");
            entity
                .Property(e => e.Type)
                .HasDefaultValueSql("'u'::\"char\"")
                .HasColumnType("char")
                .HasColumnName("type");
            entity.Property(e => e.Username).HasMaxLength(50).HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
