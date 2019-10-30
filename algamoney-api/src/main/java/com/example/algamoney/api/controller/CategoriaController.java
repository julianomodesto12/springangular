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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.example.algamoney.api.repository.CategoriaRepository;
import com.example.algamoney.api.event.RecursoCriadoEvent;
import com.example.algamoney.api.model.Categoria;


@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/api")
public class CategoriaController {
	
    @Autowired
    CategoriaRepository categoriaRepository;
    
    @Autowired
	private ApplicationEventPublisher publisher;


    @GetMapping("/categorias")
    public List<Categoria> listaCategorias(){
    	return categoriaRepository.findAll();
    }
    /*
    public ResponseEntity<?> listaCategorias(){
    	//deixar do jeito original
    	List<Categoria> categorias = categoriaRepository.findAll();
        return !categorias.isEmpty() ? ResponseEntity.ok(categorias) : ResponseEntity.noContent().build();//notContent = 204 deu certo mas nao tem nada
    }
    */

    @PostMapping("/categoria")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<Categoria> salvaCategoria(@Valid @RequestBody Categoria categoria , HttpServletResponse response ){
       Categoria categoriaSalva =  categoriaRepository.save(categoria);
        
        publisher.publishEvent(new RecursoCriadoEvent(this, response, categoriaSalva.getCatid()));
		return ResponseEntity.status(HttpStatus.CREATED).body(categoriaSalva);
    }
    
    @GetMapping("/categoria/{codigo}")
    public ResponseEntity<?>  buscaPeloCodigo(@PathVariable(value="codigo") Long catid){
    	
    	//return this.categoriaRepository.findById(catid).orElse(null);
    	
    	Optional<Categoria> categoria = categoriaRepository.findById(catid);
        
    	return !categoria.isEmpty() ? ResponseEntity.ok(categoria) : ResponseEntity.notFound().build();//notContent = 204 deu certo mas nao tem nada
    }

    /*
     @GetMapping("/{codigo}")
     public ResponseEntity buscarPeloCodigo(@PathVariable Long codigo) {
      return this.categoriaRepository.findById(codigo)
      .map(categoria -> ResponseEntity.ok(categoria))
      .orElse(ResponseEntity.notFound().build());
       }

    @GetMapping("/{codigo}")
    public ResponseEntity buscarPeloCodigo(@PathVariable Long codigo) {
    Optional categoria = this.categoriaRepository.findById(codigo);
    return categoria.isPresent() ? 
            ResponseEntity.ok(categoria.get()) : ResponseEntity.notFound().build();
}
       
     */

}
