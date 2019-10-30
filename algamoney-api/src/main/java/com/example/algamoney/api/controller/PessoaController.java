package com.example.algamoney.api.controller;

import java.net.URI;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.example.algamoney.api.event.RecursoCriadoEvent;
import com.example.algamoney.api.model.Categoria;
import com.example.algamoney.api.model.Pessoa;
import com.example.algamoney.api.repository.CategoriaRepository;
import com.example.algamoney.api.repository.PessoaRepository;
import com.example.algamoney.api.service.PessoaService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/api")
public class PessoaController {

	 @Autowired
	 PessoaRepository pessoaRepository;
	 
	 @Autowired
	 private PessoaService pessoaService;
	 
	 @Autowired
	 private ApplicationEventPublisher publisher;


	    @GetMapping("/pessoas")
	    public List<Pessoa> listaPessoas(){
	    	return pessoaRepository.findAll();
	    }
	    

	    @PostMapping("/pessoa")
	    @ResponseStatus(HttpStatus.CREATED)
	    public ResponseEntity<Pessoa> salvaPessoa(@Valid @RequestBody Pessoa pessoa , HttpServletResponse response ){
	    	Pessoa pessoaSalva =  pessoaRepository.save(pessoa);
	      
	 	        
	        publisher.publishEvent(new RecursoCriadoEvent(this, response, pessoaSalva.getPesId()));
			return ResponseEntity.status(HttpStatus.CREATED).body(pessoaSalva);
	    }
	    
	    @GetMapping("/pessoa/{codigo}")
	    public ResponseEntity<?>  buscaPeloCodigo(@PathVariable(value="codigo") Long pesId){
	    	
	   
	    	
	    	Optional<Pessoa> pessoa = pessoaRepository.findById(pesId);
	        
	    	return !pessoa.isEmpty() ? ResponseEntity.ok(pessoa) : ResponseEntity.notFound().build();//notContent = 204 deu certo mas nao tem nada
	    }	
	    
	    @DeleteMapping("/pessoa/{codigo}")
	    @ResponseStatus(HttpStatus.NO_CONTENT)
	    public void remover(@PathVariable(value="codigo") Long pesId) {
	     
	        this.pessoaRepository.deleteById(pesId);
	    }
	    
	    @PutMapping("/pessoa/{codigo}")
		public ResponseEntity<Pessoa> atualizar(@PathVariable Long codigo, @Valid @RequestBody Pessoa pessoa) {
			Pessoa pessoaSalva = pessoaService.atualizar(codigo, pessoa);
			return ResponseEntity.ok(pessoaSalva);
		}
	    
	    
	    @PutMapping("/pessoa/{codigo}/ativo")
		@ResponseStatus(HttpStatus.NO_CONTENT)
		public void atualizarPropriedadeAtivo(@PathVariable Long codigo, @RequestBody Boolean ativo) {
			pessoaService.atualizarPropriedadeAtivo(codigo, ativo);
		}
	
	  

}
