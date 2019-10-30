package com.example.algamoney.api.model;

import java.beans.Transient;
import java.math.BigDecimal;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "fin_lancamento")
public class Lancamento {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "lan_id")
	private Long lanId;
	

	public Long getLanId() {
		return lanId;
	}

	public void setLanId(Long lanId) {
		this.lanId = lanId;
	}

	@Column(name = "lan_descricao")
	@NotNull
	private String descricao;
     
	@Column(name = "lan_data_vencimento")
	@NotNull
	@JsonFormat(pattern =  "dd/MM/yyyy")
	private LocalDate dataVencimento;

	@Column(name = "lan_data_pagamento")
	@JsonFormat(pattern =  "dd/MM/yyyy")
	private LocalDate dataPagamento;

	@Column(name = "lan_valor")
	@NotNull
	private BigDecimal valor;

	@Column(name = "lan_observacao")
	private String observacao;

	@Column(name = "lan_tipo")
	@NotNull
	@Enumerated(EnumType.STRING)
	private TipoLancamento tipo;
    
	@NotNull
	@ManyToOne
	@JoinColumn(name = "cat_id")
	private Categoria categoria;

	@NotNull
	@ManyToOne
	@JoinColumn(name = "pes_id")
	private Pessoa pessoa;
	

	
	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public LocalDate getDataVencimento() {
		return dataVencimento;
	}

	public void setDataVencimento(LocalDate dataVencimento) {
		this.dataVencimento = dataVencimento;
	}

	public LocalDate getDataPagamento() {
		return dataPagamento;
	}

	public void setDataPagamento(LocalDate dataPagamento) {
		this.dataPagamento = dataPagamento;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}

	public TipoLancamento getTipo() {
		return tipo;
	}

	public void setTipo(TipoLancamento tipo) {
		this.tipo = tipo;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((lanId == null) ? 0 : lanId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Lancamento other = (Lancamento) obj;
		if (lanId == null) {
			if (other.lanId != null)
				return false;
		} else if (!lanId.equals(other.lanId))
			return false;
		return true;
	}

}