package com.example.algamoney.api.service;

import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.example.algamoney.api.model.Pessoa;
import com.example.algamoney.api.repository.PessoaRepository;

@Service
public class PessoaService {
	
	@Autowired
	private PessoaRepository pessoaRepository;

	public Pessoa atualizar(Long pesId, Pessoa pessoa) {
		 Pessoa pessoaSalva = this.pessoaRepository.findById(pesId)
			      .orElseThrow(() -> new EmptyResultDataAccessException(1));

			  BeanUtils.copyProperties(pessoa, pessoaSalva, "codigo");

			  return this.pessoaRepository.save(pessoaSalva);
	}
	
	
	public void atualizarPropriedadeAtivo(Long codigo, Boolean ativo) {
		
		Pessoa pessoaSalva = buscarPessoaPeloCodigo(codigo);
		pessoaSalva.setPesAtivo(ativo);
		pessoaRepository.save(pessoaSalva);
	}
	
	private Pessoa buscarPessoaPeloCodigo(Long pesId) {
	    
		Pessoa pessoaSalva;
		
		
		if (pessoaRepository.findById(pesId).isEmpty()) {
			throw new EmptyResultDataAccessException(1);
		}
		else
		{
			 pessoaSalva = pessoaRepository.findById(pesId).get() ;
		}
         
	
		return  pessoaSalva;
	}
	
}
