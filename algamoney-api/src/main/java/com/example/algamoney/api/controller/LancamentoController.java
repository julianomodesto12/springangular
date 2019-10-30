package com.example.algamoney.api.controller;

import java.util.List;
import java.util.Optional;

import java.util.Arrays;


import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.example.algamoney.api.event.RecursoCriadoEvent;
import com.example.algamoney.api.model.Lancamento;
import com.example.algamoney.api.model.Pessoa;
import com.example.algamoney.api.repository.LancamentoRepository;
import com.example.algamoney.api.repository.PessoaRepository;
import com.example.algamoney.api.repository.filter.LancamentoFilter;
import com.example.algamoney.api.service.LancamentoService;
import com.example.algamoney.api.service.PessoaService;
import com.example.algamoney.api.service.exception.PessoaInexistenteOuInativaException;
import com.example.algamoney.api.exceptionhandler.AlgamoneyExceptionHandler.Erro;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/api")
public class LancamentoController {

	 @Autowired
	 LancamentoRepository lancamentoRepository;
	 
	 @Autowired
	 private LancamentoService lancamentoService;
		
	 @Autowired
	 private ApplicationEventPublisher publisher;
		
	 @Autowired
	 private MessageSource messageSource;
	 
	 
	 @GetMapping("/lancamentos")
	 public Page<Lancamento> pesquisar(LancamentoFilter lancamentoFilter, Pageable pageable) {
			return lancamentoRepository.filtrar(lancamentoFilter, pageable);
		}

        /*
	    @GetMapping("/lancamentos")
	    public List<Lancamento> listaLancamentos(){
	    	return lancamentoRepository.findAll();
	    }
	    */

	    
	    @GetMapping("/lancamento/{codigo}")
	    public ResponseEntity<?>  buscaPeloCodigo(@PathVariable(value="codigo") Long lanId){
	    	
	   
	    	
	    	Optional<Lancamento> lancamento = lancamentoRepository.findById(lanId);
	        
	    	return !lancamento.isEmpty() ? ResponseEntity.ok(lancamento) : ResponseEntity.notFound().build();//notContent = 204 deu certo mas nao tem nada
	    }	
	    

	    @PostMapping("/lancamento")
	    @ResponseStatus(HttpStatus.CREATED)
	    public ResponseEntity<Lancamento> salvaLancamento(@Valid @RequestBody Lancamento lancamento , HttpServletResponse response ){
	    	Lancamento lancamentoSalvo = lancamentoService.salvar(lancamento);
			publisher.publishEvent(new RecursoCriadoEvent(this, response, lancamentoSalvo.getLanId()));
			return ResponseEntity.status(HttpStatus.CREATED).body(lancamentoSalvo);
	    	/*
	    	Lancamento lancamentoSalva =  lancamentoRepository.save(lancamento);
	      
	 	        
	        publisher.publishEvent(new RecursoCriadoEvent(this, response, lancamentoSalva.getLanId()));
			return ResponseEntity.status(HttpStatus.CREATED).body(lancamentoSalva);
			*/
	    }
	    
	    @ExceptionHandler({ PessoaInexistenteOuInativaException.class })
		public ResponseEntity<Object> handlePessoaInexistenteOuInativaException(PessoaInexistenteOuInativaException ex) {
			String mensagemUsuario = messageSource.getMessage("pessoa.inexistente-ou-inativa", null, LocaleContextHolder.getLocale());
			String mensagemDesenvolvedor = ex.toString();
			
			List<Erro> erros = Arrays.asList(new Erro(mensagemUsuario, mensagemDesenvolvedor));
			return ResponseEntity.badRequest().body(erros);
		}

	    @DeleteMapping("/lancamento/{codigo}")
	    @ResponseStatus(HttpStatus.NO_CONTENT)
	    public void remover(@PathVariable(value="codigo") Long lanId) {
	     
	        this.lancamentoRepository.deleteById(lanId);
	    }

}
