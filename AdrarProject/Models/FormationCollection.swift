//
//  FormationUtilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

// Utilisé pour Tester sur rendu graphique tant que la BD n'est pas mise en place.
import UIKit

class FormationCollection{
    func all() -> [Formation]{
        var formations: [Formation] = []
        
        formations.append(Formation(
            intitule: "Technicien Supérieur Systèmes et Réseaux",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae quam a orci dignissim dapibus ac sit amet augue. Pellentesque vehicula est ante, quis dictum ipsum scelerisque sed. Suspendisse volutpat, sem sit amet mollis pellentesque, felis sem ultricies purus, quis gravida lectus libero vitae enim. Maecenas quis tellus imperdiet, molestie urna eleifend, facilisis libero. Donec a posuere eros. Donec imperdiet ornare sodales. Sed placerat dolor ex, eu tristique purus ultricies ut. Nunc consectetur sapien sapien, id pretium nulla congue sit amet.Integer vestibulum non enim non aliquam. Aenean non augue aliquet, porttitor justo non, vehicula libero. Fusce ante erat, fringilla sit amet blandit in, dapibus sollicitudin est. Aliquam quis sodales enim. Ut ut arcu congue, laoreet tortor non, molestie augue. Integer malesuada vulputate urna, non porta felis aliquet non. Pellentesqxrxue feugiat ultrices laoreet. Proin sit amet suscipit tellus, nec congue elit. Aliquam dictum lectus ac est dictum, et accumsan erat molestie. Donec mattis nulla sit amet venenatis malesuada. Nunc lacus ante, rhoncus sed magna sed, gravida ornare nisi. Etiam fermentum semper massa, accumsan hendrerit nunc cursus sit amet. In hac habitasse platea dictumst. Phasellus vestibulum sapien mauris, id blandit est luctus vitae. Curabitur tincidunt ipsum cursus magna interdum, nec cursus diam bibendum.Nulla venenatis efficitur vestibulum. Vestibulum vitae erat id augue auctor elementum sit amet ac dolor. Quisque vitae placerat elit. Pellentesque nec sodales nisl, ac sagittis urna. In eget condimentum augue. Integer malesuada auctor enim, at finibus dolor consequat et. Integer vel dapibus justo. Etiam sed nibh rhoncus erat ultrices porta vitae vel ipsum. Praesent vulputate nisi et purus volutpat commodo. Quisque eu turpis justo. Praesent lobortis dapibus dictum. Fusce aliquet, tortor eget vehicula suscipit, nisi sapien tempor ante, et porta sem ex quis dui. Nunc sed tellus vel sem laoreet laoreet eu et tortor. Maecenas nec augue ex. Etiam vel fermentum turpis.Nullam eu libero bibendum, pharetra metus sit amet, laoreet urna. Mauris mattis et lacus at faucibus. Nulla lorem nisl, dignissim at lorem vitae, mattis euismod libero. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum tempus pulvinar dolor non varius. Sed consequat nisl ut libero porttitor, sit amet varius sem lobortis. In eu quam laoreet, convallis turpis vitae, volutpat nulla. Duis accumsan elit eget tellus posuere, at efficitur leo rutrum. Duis a fermentum nisl. Aliquam pulvinar efficitur hendrerit. Aenean pulvinar libero et purus placerat, id vestibulum neque sollicitudin. Nunc ullamcorper lacus quis faucibus congue.Fusce aliquet maximus consequat. Aenean pellentesque at ipsum nec lacinia. Suspendisse tincidunt urna vitae venenatis porta. Morbi mattis diam eu ipsum pulvinar dignissim. Pellentesque molestie sapien eget volutpat efficitur. Aenean pharetra, erat sit amet rutrum aliquam, nunc sem fermentum diam, at euismod odio massa vitae velit. Cras vestibulum feugiat iaculis. Nullam consectetur diam purus, eu efficitur lectus pretium nec. Quisque tincidunt sem et eros aliquam vestibulum. Nam eros turpis, volutpat vitae sem eget, consectetur convallis mi.Aliquam erat volutpat. Sed justo magna, sollicitudin ut nisl et, aliquam vehicula diam. Aenean ut erat vitae ex sollicitudin lobortis non ac ex. Fusce quam erat, vehicula blandit tortor quis, dictum porta tellus. Suspendisse neque sapien, gravida ut blandit vitae, maximus et orci. Aliquam eget sagittis ligula, sit amet vestibulum erat. Cras facilisis nisl elit, sit amet porta sapien rhoncus in. In mattis orci mi, vitae euismod massa pharetra nec. Donec malesuada, ligula vitae convallis porttitor, ligula dui efficitur sem, id scelerisque ipsum ligula quis tortor. Mauris ac lacus eu quam faucibus elementum. Nunc tincidunt sodales augue, ac scelerisque nunc hendrerit sollicitudin. Nam gravida vehicula nulla id molestie. Integer non tristique lectus. Donec a mauris tellus.Duis erat lectus, sagittis at interdum vel, bibendum sit amet ante. Donec imperdiet, est malesuada posuere tempus, diam ipsum ullamcorper justo, eget dapibus dolor diam at augue. Suspendisse cursus, nisl eget sodales iaculis, felis sem rutrum diam, a maximus arcu nunc ac lacus. Aliquam eros tortor, mollis non mi vel, finibus egestas orci. Nullam erat massa, maximus quis ex finibus, ultrices imperdiet mauris. Mauris luctus nunc scelerisque, rutrum orci eget, scelerisque lacus. Ut quis vestibulum nibh. Quisque quis urna diam. Integer facilisis, nunc et ornare mollis, ligula enim ullamcorper justo, ac iaculis ligula elit vitae enim. Proin felis nulla, maximus ac arcu et, lobortis consectetur magna. Vivamus commodo diam sit amet dolor fringilla euismod. Etiam pellentesque, libero at imperdiet lacinia, magna dolor iaculis quam, eu fringilla dui ex in sem. Mauris at nunc sapien.Nunc justo urna, pulvinar ac ligula et, fermentum ornare tortor. Integer pretium placerat ipsum nec pellentesque. Sed tristique augue massa, in euismod urna rutrum eget. In hac habitasse platea dictumst. Nunc congue volutpat dui, sed vulputate mi consectetur eget. Sed eros turpis, pellentesque et vestibulum eu, vehicula id eros. Aenean nunc justo, ornare vel malesuada a, suscipit eget enim. Donec cursus, nunc at sollicitudin tincidunt, dui erat sodales metus, sed lobortis odio libero vitae elit. Morbi sit amet urna vehicula, feugiat urna ut, commodo dolor. Proin eu sapien fermentum, aliquam tellus eu, vulputate ligula. Curabitur vel faucibus ligula, id vestibulum tellus. Nunc bibendum auctor libero eget efficitur. Ut sit amet tempus metus, sit amet vestibulum quam. Suspendisse porta vel felis vitae imperdiet. Sed luctus libero non lacinia congue.Proin malesuada, nibh at pharetra accumsan, lacus sapien egestas arcu, vel vehicula magna diam non risus. Mauris auctor faucibus laoreet. Donec ullamcorper euismod lectus quis pharetra. Quisque vehicula diam id cursus maximus. In gravida vulputate justo et feugiat. Proin ut massa eros. Nullam tempus, nisl vel accumsan venenatis, urna turpis iaculis dolor, ac suscipit tortor dolor vitae tortor. Maecenas porttitor lectus nec lacinia aliquam. Integer lacinia ornare facilisis. Fusce pulvinar turpis et sapien fringilla, vitae tincidunt dolor egestas. Ut venenatis libero sit amet diam molestie porta. Ut et lacus efficitur, tristique est eu, viverra ante. Duis mattis eros sed porttitor pretium. Ut nec diam quis libero luctus hendrerit. Pellentesque a mauris non leo laoreet rhoncus id eu urna.Maecenas euismod velit at massa aliquam placerat. Nullam rutrum turpis sit amet sapien commodo vehicula. Mauris laoreet urna a nisi cursus, auctor dignissim lacus egestas. Curabitur ac dui neque. Mauris accumsan justo id tortor finibus vehicula. Pellentesque fermentum, enim vel gravida feugiat, lectus lacus cursus diam, nec sollicitudin eros ligula in enim. Donec varius consequat nulla ac aliquet. Proin lobortis sapien ut odio porttitor tempus. Duis eget ornare purus, id sagittis massa. Ut sit amet pretium lorem.",
             type:0
            )
        )
        formations.append(Formation(
            intitule: "Dev 1",
            description: "Dev1",
             type:0
            )
        )
        formations.append(Formation(
            intitule: "Res 0",
            description: "Res0",
            type:0
            )
        )
        formations.append(Formation(
            intitule: "Res 1",
            description: "Res1",
             type:0
            )
        )
        
        
        return formations
    }
    
    
    
}
