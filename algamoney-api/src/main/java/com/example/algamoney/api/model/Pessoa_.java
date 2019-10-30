package com.example.algamoney.api.model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Pessoa.class)
public abstract class Pessoa_ {

	public static volatile SingularAttribute<Pessoa, Long> pesId;
	public static volatile SingularAttribute<Pessoa, Boolean> pesAtivo;
	public static volatile SingularAttribute<Pessoa, Endereco> endereco;
	public static volatile SingularAttribute<Pessoa, String> pesNome;

	public static final String PES_ID = "pesId";
	public static final String PES_ATIVO = "pesAtivo";
	public static final String ENDERECO = "endereco";
	public static final String PES_NOME = "pesNome";

}

