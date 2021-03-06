#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Plack::Builder;

# use this block if you don't need middleware, and only have a single target Dancer app to run here
use Config::App;
use Routes::Criador;
use Routes::Distrito;
use Routes::Departamento;
use Routes::EstadoCriador;
use Routes::Mascota;
use Routes::Pais;
use Routes::Provincia;
use Routes::Raza;
use Routes::TipoMascota;

builder {
  enable 'Deflater';
  Config::App->to_app;
  mount '/'      => Config::App->to_app;
  mount '/criador'      => Routes::Criador->to_app;
  mount '/departamento'      => Routes::Departamento->to_app;
  mount '/distrito'      => Routes::Distrito->to_app;
  mount '/estado_criador'      => Routes::EstadoCriador->to_app;
  mount '/mascota'      => Routes::Mascota->to_app;
  mount '/pais'      => Routes::Pais->to_app;
  mount '/provincia'      => Routes::Provincia->to_app;
  mount '/raza'      => Routes::Raza->to_app;
  mount '/tipo_mascota'      => Routes::TipoMascota->to_app;
}

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use Gestion::App;
use Plack::Builder;

builder {
    enable 'Deflater';
    Gestion::App->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use Gestion::App;
use Gestion::App_admin;

use Plack::Builder;

builder {
    mount '/'      => Gestion::App->to_app;
    mount '/admin'      => Gestion::App_admin->to_app;
}

=end comment

=cut
