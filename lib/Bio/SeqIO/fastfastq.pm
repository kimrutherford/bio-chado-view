# A faster parser for fastq
#
# POD documentation - main docs before the code

=head1 NAME

Bio::SeqIO::fastfastq - faster fastq sequence input/output stream

=head1 SYNOPSIS

Do not use this module directly.  Use it via the Bio::SeqIO class.

=head1 DESCRIPTION

=cut

package Bio::SeqIO::fastfastq;
use strict;

use Bio::Seq::SeqFactory;

use base qw(Bio::SeqIO);

sub _initialize {
  my($self,@args) = @_;
  $self->SUPER::_initialize(@args);  
}


=head2 next_seq

 Title   : next_seq
 Usage   : $seq = $stream->next_seq()
 Function: returns the next sequence in the stream
 Returns : a hash of information about one sequence containing {id => ...,
           sequence => ..., quality => ...}
 Args    : NONE

=cut

sub next_seq {
  my( $self ) = @_;
  my $seq;
  local $/ = "\n";
  my $seqdata;
  my @datatype = qw(id sequence qualdesc quality);
  for my $type (@datatype) {
    return unless my $line = $self->_readline; # bail if any data is incomplete
    chomp $line;
    if ($type eq 'id' || $type eq 'qualdesc') {
      if ($line =~ m{^[\+@](.*)$}) {
        $line = $1;
      } else {
        $self->throw("$line doesn't match fastq descriptor line type");
      }
    }
    if ($type ne 'qualdesc') {
      $seqdata->{$type} = $line;
    }
  }
  my ($identifier,$fulldesc) = $seqdata->{id} =~ /^\s*(\S+)\s*(.*)/
    or $self->throw("Can't parse fastq header");
  if ($identifier eq '') {
    $identifier=$fulldesc;
  }
  $seqdata->{id} = $identifier;
  $seqdata->{sequence} =~ s/\s//g;
  $seqdata->{quality} =~ s/\s//g;
  
  if(length($seqdata->{sequence}) != length($seqdata->{quality})){
    $self->warn("Fastq sequence/quality data length mismatch error\n",
                "Sequence: ", $seqdata->{id}, ", seq length: ",
                length($seqdata->{sequence}), " Qual length: ",
                length($seqdata->{quality}), " \n",
                $seqdata->{sequence},"\n",$seqdata->{quality},"\n");
  }

  return $seqdata;
}

1;
