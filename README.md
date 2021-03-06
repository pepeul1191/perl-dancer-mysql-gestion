## Perl Dancer

Instalación de paquetes de CPANM

    $ sudo apt-get install cpanminus libdbd-firebird-perl libmysqlclient-dev
    $ curl -L http://cpanmin.us | perl - --sudo Dancer2
    $ sudo cpanm Plack::Middleware::Deflater DBD::SQLite DBD::mysql JSON JSON::Create JSON::XS Crypt::MCrypt Try::Tiny Plack::Loader::Shotgun Plack::Handler::Starman

Arrancar Dancer:

    $ plackup -r bin/app.psgi -p 4000

Arrancar Dancer con autoreload luego de hacer cambios:

    $ plackup -L Shotgun bin/app.psgi -p 4000


Arrancar en modo de producción con workers:

    $ plackup -E deployment -s Starman --workers=50 -p 4000 -a bin/app.psgi

Para imprimir variables:

    #print("\nA\n");print($url);print("\nB\n");
    #print("\n");print Dumper(%temp);print("\n");

### Migraciones

Ejecutar migración

    $ sequel -m db/migrations -M #version postgres://host/database
    $ sequel -m db/migrations -M #version sqlite://db/gestion.db
    $ sequel -m db/migrations -M #version mysql://root:123@localhost/gestion

Ejecutar el 'down' de las migraciones de la última a la primera:

    $ sequel -m db/migrations -M 0 mysql://root:123@localhost/gestion

Ejecutar el 'up' de las migraciones hasta un versión especifica:

    $ sequel -m db/migrations -M #version mysql://root:123@localhost/gestion

Crear Vista de distrito/provincia/departamento

    MySQL
    >> CREATE VIEW vw_distrito_provincia_departamento AS select DI.id AS id, PA.id AS pais_id, concat(DI.nombre,', ',PR.nombre,', ',DE.nombre) AS nombre from ((distritos DI join provincias PR on((DI.provincia_id = PR.id))) join departamentos DE on((PR.departamento_id = DE.id))) join paises PA on((DE.pais_id = PA.id)) limit 2000;
    SQLite
    >> CREATE VIEW vw_distrito_provincia_departamento AS select DI.id AS id, PA.id AS pais_id,  DI.nombre || ', '  || PR.nombre || ', '  || DE.nombre AS nombre from ((distritos DI join provincias PR on((DI.provincia_id = PR.id))) join departamentos DE on((PR.departamento_id = DE.id))) join paises PA on((DE.pais_id = PA.id)) limit 2000;

Tipos de Datos de Columnas

+ :string=>String
+ :integer=>Integer
+ :date=>Date
+ :datetime=>[Time, DateTime].freeze,
+ :time=>Sequel::SQLTime,
+ :boolean=>[TrueClass, FalseClass].freeze,
+ :float=>Float
+ :decimal=>BigDecimal
+ :blob=>Sequel::SQL::Blob

---

Fuentes:

+ http://blog.endpoint.com/2015/01/cleaner-redirection-in-perl-dancer.html
+ http://search.cpan.org/~xsawyerx/Dancer2-0.200002/lib/Dancer2/Manual/Deployment.pod
+ http://search.cpan.org/dist/Dancer/lib/Dancer/Deployment.pod
+ https://stackoverflow.com/questions/17144583/dbd-mysql-installed-but-still-error-install-drivermysql-failed-cant-locate
+ www.dacostabalboa.es/wp-content/uploads/2010/07/Plantila-base-datos-perros.xls
+ http://www.buggol.com/lista-razas-de-gatos.php
