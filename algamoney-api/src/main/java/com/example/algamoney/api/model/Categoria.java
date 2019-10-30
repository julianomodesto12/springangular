package com.example.algamoney.api.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="fin_categoria")
/* @JsonIgnoreProperties(ignoreUnknown = true) */
public class Categoria implements Serializable {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	@Column(name = "cat_id")
	private Long catid ;
	
	@Column(name = "cat_nome")
	@NotNull
	@Size(min = 3, max = 50)
	private String catnome ;
	
	public Long getCatid() {
		return catid;
	}

	public void setCatid(Long catid) {
		this.catid = catid;
	}

	public String getCatnome() {
		return catnome;
	}

	public void setCatnome(String catnome) {
		this.catnome = catnome;
	}


	
	

}