-- Alunos: Rubens Ferreira e Mateus Felipe

create schema db_agentamentos;

create table if not exists db_agentamentos.pessoa(
    cpf char(11) primary key,
    email varchar(50) not null ,
    nome varchar(150) not null ,
    data_nasc date not null,
    endereco varchar(300) not null,
    telefone varchar(15),

    constraint unique_nome_email
        unique (nome, email)
);

create table if not exists db_agentamentos.paciente(
    cpf_pessoa char(11) primary key not null,
    senha varchar(20) not null,
    plano_saude boolean not null default False,

    constraint paciente_pessoa_fk foreign key (cpf_pessoa) references db_agentamentos.pessoa(cpf)
);

create table if not exists db_agentamentos.medico(
    cpf_pessoa char(11) primary key not null,
    crm varchar(10) unique not null,

    constraint medico_pessoa_fk foreign key (cpf_pessoa) references db_agentamentos.pessoa(cpf)
);

create table if not exists db_agentamentos.agendamento(
    cpf_paciente char(11) not null,
    cpf_medico char(11) not null,
    dh_consulta timestamp not null,
    dh_agendamento timestamp not null,
    valor_consulta float not null default '0.0',

    CONSTRAINT agendamento_pk PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta),
    constraint agendamento_paciente_fk foreign key (cpf_paciente) references db_agentamentos.paciente(cpf_pessoa),
    constraint agendamento_medico_fk foreign key (cpf_medico) references db_agentamentos.medico(cpf_pessoa)
);



create table if not exists db_agentamentos.especialidade(
    id int generated always as identity primary key,
    descricao varchar(300) not null
);

create table if not exists db_agentamentos.medico_especialidade(
    cpf_medico char(11) not null,
    id_especialidade int not null,

    CONSTRAINT medico_especialidade_pk PRIMARY KEY (cpf_medico, id_especialidade),
    constraint medico_especialidade_medico_fk foreign key (cpf_medico) references db_agentamentos.medico(cpf_pessoa),
    constraint medico_especialidade_especialidade_fk foreign key (id_especialidade) references db_agentamentos.especialidade(id)
);
