package com.example.algamoney.api.model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value = "org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
@StaticMetamodel(Endereco.class)
public abstract class Endereco_ {

	public static volatile SingularAttribute<Endereco, String> pesComplemento;
	public static volatile SingularAttribute<Endereco, String> pesCep;
	public static volatile SingularAttribute<Endereco, String> pesLogradouro;
	public static volatile SingularAttribute<Endereco, String> pesEstado;
	public static volatile SingularAttribute<Endereco, Integer> pesNumero;
	public static volatile SingularAttribute<Endereco, String> pesCidade;
	public static volatile SingularAttribute<Endereco, String> pesBairro;

	public static final String PES_COMPLEMENTO = "pesComplemento";
	public static final String PES_CEP = "pesCep";
	public static final String PES_LOGRADOURO = "pesLogradouro";
	public static final String PES_ESTADO = "pesEstado";
	public static final String PES_NUMERO = "pesNumero";
	public static final String PES_CIDADE = "pesCidade";
	public static final String PES_BAIRRO = "pesBairro";

}

