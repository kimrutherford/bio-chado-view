package SmallRNA::Parse::SSAHA;

=head1 NAME

SmallRNA::Parse::SSAHA - A parser for ssaha output

=head1 SYNOPSIS

=head1 AUTHOR

Kim Rutherford C<< <kmr44@cam.ac.uk> >>

=head1 BUGS

Please report any bugs or feature requests to C<kmr44@cam.ac.uk>.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SmallRNA::Parse::SSAHA

=over 4

=back

=head1 COPYRIGHT & LICENSE

Copyright 2009 Kim Rutherford, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 FUNCTIONS

=cut

use strict;
use warnings;
use Carp;
use Params::Validate;

=head2 new

 Usage   : my $parser = SmallRNA::Parse::SSAHA->new(input_file_handle => $fh);
 Function: Create and return a new parser, reading from the given file handle
 Args    : input_file_handle - file handler to read from
           format - "standard" for the default SSAHA output, or "pf" for the
                    output when using the -pf SSAHA flag

=cut
sub new
{
  my $class = shift;

  my %params = validate(@_, { input_file_handle => 1, format => 1 });

  my $self = { fh => $params{input_file_handle},
               format => $params{format} };

  return bless $self, $class;
}

my $pf_re = qr(
                ^
                ([FR][FR])
                \s+
                (\S+) \s+ (\d+) \s+ (\d+)  # query id, start end
                \s+
                (\S+) \s+ (\d+) \s+ (\d+)  # subject id, start end
                \s+
                (\d+)       # number of matches bases
                \s+
                ([\d\.]+)   # percent identity
             )x;

sub _next_pf
{
  my $self = shift;

  my $fh = $self->{fh};

  my $line = <$fh>;

  if ($line =~ m/$pf_re/x) {
    my $strands = $1;
    my $forward_match;
    if ($strands eq 'FF') {
      $forward_match = 1;
    } else {
      $forward_match = 0;
    }

    my ($qid, $qstart, $qend) = ($2, $3, $4);
    my ($sid, $sstart, $send) = ($5, $6, $7);
    my ($matching_bases, $percent_id) = ($8, $9);

    return { forward_match => 1,
             qid => $qid,
             qstart => $qstart,
             qend => $qend,
             sid => $sid,
             sstart => $sstart,
             send => $send,
             matching_base_count => $matching_bases,
             percent_id => $percent_id,
           }
  } else {
    die "failed to parse: $line\n";
  }
}

my $standard_re =
  qr(
     ^
     ([FR][FR])
     \s+
     (\S+)
     \s+:\s+
     (\S+)
     \s+
     Score:\s+(\d+)
     \s+
     Q:\s+(\d+)\s+to\s+(\d+)
     \s+
     S:\s+(\d+)\s+to\s+(\d+)
     \s+
     (\d+\.\d+)\%
    )x;

sub _next_standard
{
  my $self = shift;

  my $fh = $self->{fh};

  while (defined (my $line = <$fh>)) {
    if ($line =~ /Matches For Query \d+ \((\d+) bases\): (\S+)/) {
      $self->{current_identifer} = $2;
      $self->{current_length} = $1;
    } else {
      if ($line =~ m/$standard_re/x) {
        my $strands = $1;
        my $forward_match;
        if ($strands eq 'FF') {
          $forward_match = 1;
        } else {
          $forward_match = 0;
        }

        my ($qstart, $qend) = ($5, $6);
        my ($sstart, $send) = ($7, $8);

        my ($matching_bases, $percent_id) = ($4, $9);

        my $sid = $3;

        return { forward_match => $forward_match,
                 qid => $self->{current_identifer},
                 qstart => $qstart,
                 qend => $qend,
                 qlength => $self->{current_length},
                 sid => $sid,
                 sstart => $sstart,
                 send => $send,
                 matching_base_count => $matching_bases,
                 percent_id => $percent_id,
           }
      } else {
        die q/didn't match this line: /, $line unless $line =~ /^\s*$/;
      }
    }
  }

  return undef;

}

=head2 next

 Usage   : my $match = $parser->next();
 Function: return information about the next match from the input SSAHA stream
 Args    : None
 Returns : a hash ref containing with these keys:
               qid - query id
               qstart - query start
               qend - query end
               sid - subject id
               sstart - subject start
               send - subject end
               forward_match - true iff the query hit the forward strand of the
                               subject
               matching_base_count - the number of matching bases
               percent_id - the percentage identity in the match
           or undef if there are no more matches

=cut
sub next
{
  my $self = shift;

  my $fh = $self->{fh};

  if (!defined $fh) {
    # last call to next() hit EOF
    return undef;
  }

  my $result;

  if ($self->{format} eq 'pf') {
    $result = $self->_next_pf();
  } else {
    $result = $self->_next_standard();
  }

  if (defined $result) {
    return $result;
  } else {
    $self->{fh} = undef;
    return undef;
  }
}


1;

