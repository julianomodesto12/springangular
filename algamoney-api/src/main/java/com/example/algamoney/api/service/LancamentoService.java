package com.example.algamoney.api.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.example.algamoney.api.model.Lancamento;
import com.example.algamoney.api.model.Pessoa;
import com.example.algamoney.api.repository.LancamentoRepository;
import com.example.algamoney.api.repository.PessoaRepository;
import com.example.algamoney.api.service.exception.PessoaInexistenteOuInativaException;

@Service
public class LancamentoService {
	
	@Autowired
	private PessoaRepository pessoaRepository;
	
	@Autowired 
	private LancamentoRepository lancamentoRepository;

	public Lancamento salvar(Lancamento lancamento) {
		
	 
	  
		Pessoa pessoa;
		
		
		if (pessoaRepository.findById(lancamento.getPessoa().getPesId()).isEmpty()) {
			throw new EmptyResultDataAccessException(1);
		}
		else
		{
			pessoa = pessoaRepository.findById(lancamento.getPessoa().getPesId()).get() ;
		}
		
		if (pessoa.isInativo()) {
			throw new PessoaInexistenteOuInativaException();
		}
       
	
		return lancamentoRepository.save(lancamento);
		
	    
		
		
	}
	
}