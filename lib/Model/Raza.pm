package Model::Raza;
use Config::Database;

sub new {
  my $class = shift;
  my $db = 'Config::Database';
  my $odb= $db->new();
  my $dbh = $odb->getConnection();
  my $self = {
    _dbh => $dbh
  };
  bless $self, $class;
  return $self;
}

sub commit {
  my($self) = @_;
  $self->{_dbh}->commit;
}

sub rollback {
  my($self) = @_;
  $self->{_dbh}->rollback;
}

sub listar {
  my($self) = @_;
  my $sth = $self->{_dbh}->prepare('SELECT id, nombre, nombre_cientifico FROM razas;')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my @rpta;
  while (my $ref = $sth->fetchrow_hashref()) {
    push @rpta, $ref;
  }
  $sth->finish;
  return @rpta;
}

sub crear {
  my($self, $nombre, $nombre_cientifico) = @_;
  my $sth = $self->{_dbh}->prepare('INSERT INTO razas (nombre, nombre_cientifico) VALUES (?,?)')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->bind_param( 2, $nombre_cientifico);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  my $id_generated = $self->{_dbh}->last_insert_id(undef, undef, undef, undef );
  $sth->finish;
  return $id_generated;
}

sub editar {
  my($self, $id, $nombre, $nombre_cientifico) = @_;
  my $sth = $self->{_dbh}->prepare('UPDATE razas SET nombre = ?, nombre_cientifico = ? WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $nombre);
  $sth->bind_param( 2, $nombre_cientifico);
  $sth->bind_param( 3, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

sub eliminar {
  my($self, $id) = @_;
  my $sth = $self->{_dbh}->prepare('DELETE FROM razas WHERE id = ?')
    or die "prepare statement failed: $dbh->errstr()";
  $sth->bind_param( 1, $id);
  $sth->execute() or die "execution failed: $dbh->errstr()";
  $sth->finish;
}

1;
