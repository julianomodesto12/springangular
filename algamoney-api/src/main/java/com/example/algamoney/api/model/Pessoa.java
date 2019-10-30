package com.example.algamoney.api.model;

import java.beans.Transient;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.example.algamoney.api.model.Endereco;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="fin_pessoa")
public class Pessoa {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	@Column(name = "pes_id")
	private Long pesId ;
	
	@Column(name = "pes_nome")
	@NotNull
	@Size(min = 3, max = 90)
	private String pesNome ;
	
	@Column(name = "pes_ativo")
	private Boolean pesAtivo ;
	
	@JsonIgnore
	@Transient
	public boolean isInativo() {
		return !this.pesAtivo;
	}

	
	

	@Embedded
	private Endereco endereco;

	public Long getPesId() {
		return pesId;
	}

	public void setPesId(Long pesId) {
		this.pesId = pesId;
	}

	public String getPesNome() {
		return pesNome;
	}

	public void setPesNome(String pesNome) {
		this.pesNome = pesNome;
	}

	public Endereco getEndereco() {
		return endereco;
	}

	public void setEndereco(Endereco endereco) {
		this.endereco = endereco;
	}
	
	public Boolean getPesAtivo() {
		return pesAtivo;
	}

	public void setPesAtivo(Boolean pesAtivo) {
		this.pesAtivo = pesAtivo;
	}
	
	

}
