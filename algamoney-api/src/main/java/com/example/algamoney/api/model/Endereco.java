package com.example.algamoney.api.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.Size;

@Embeddable
public class Endereco {
	
	@Column(name = "pes_logradouro")
	@Size(min = 3, max = 100)
	private String pesLogradouro ;
	
	@Column(name = "pes_numero")
	private Integer pesNumero ;
	
	@Column(name = "pes_complemento")
	@Size(min = 1, max = 50)
	private String pesComplemento ;

	@Column(name = "pes_bairro")
	@Size(min = 1, max = 80)
	private String pesBairro ;
	
	@Column(name = "pes_cep")
	@Size(min = 1, max = 9)
	private String pesCep ;

	@Column(name = "pes_cidade")
	@Size(min = 1, max = 80)
	private String pesCidade ;
	
	@Column(name = "pes_estado")
	@Size(min = 1, max = 40)
	private String pesEstado ;

	public String getPesLogradouro() {
		return pesLogradouro;
	}

	public void setPesLogradouro(String pesLogradouro) {
		this.pesLogradouro = pesLogradouro;
	}

	public Integer getPesNumero() {
		return pesNumero;
	}

	public void setPesNumero(Integer pesNumero) {
		this.pesNumero = pesNumero;
	}

	public String getPesComplemento() {
		return pesComplemento;
	}

	public void setPesComplemento(String pesComplemento) {
		this.pesComplemento = pesComplemento;
	}

	public String getPesBairro() {
		return pesBairro;
	}

	public void setPesBairro(String pesBairro) {
		this.pesBairro = pesBairro;
	}

	public String getPesCep() {
		return pesCep;
	}

	public void setPesCep(String pesCep) {
		this.pesCep = pesCep;
	}

	public String getPesCidade() {
		return pesCidade;
	}

	public void setPesCidade(String pesCidade) {
		this.pesCidade = pesCidade;
	}

	public String getPesEstado() {
		return pesEstado;
	}

	public void setPesEstado(String pesEstado) {
		this.pesEstado = pesEstado;
	}	
	
	
	
	

}
