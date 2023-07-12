
import 'package:equatable/equatable.dart';


enum FormzStatus {pure, valid, invalid, submissionInProgress, submissionSuccess, submissionFailure}




// class FormzStatus extends Equatable {
//   const FormzStatus._(this._status);

//   final String _status;

//   static const FormzStatus pure = FormzStatus._('pure');
//   static const FormzStatus pristine = FormzStatus._('pristine');
//   static const FormzStatus valid = FormzStatus._('valid');
//   static const FormzStatus invalid = FormzStatus._('invalid');

//   bool get isPure => _status == 'pure';
//   bool get isPristine => _status == 'pristine';
//   bool get isValid => _status == 'valid';
//   bool get isInvalid => _status == 'invalid';

//   @override
//   List<Object?> get props => [_status];
// }
