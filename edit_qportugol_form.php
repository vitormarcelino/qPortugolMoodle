<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Defines the editing form for the qportugol question type.
 *
 * @package    qtype
 * @subpackage qportugol
 * @copyright  2017 Vitor Marcelino, Leonardo Menezes e Guna Alexander
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */


defined('MOODLE_INTERNAL') || die();


/**
 * QPortugol question type editing form.
 *
 * @copyright  2017 Vitor Marcelino, Leonardo Menezes e Guna Alexander
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class qtype_qportugol_edit_form extends question_edit_form {

    protected function definition_inner($mform) {
        $qtype = question_bank::get_qtype('qportugol');

        $mform->addElement('header', 'responsetemplateheader', get_string('responsetemplateheader', 'qtype_qportugol'));
        $mform->addElement('textarea', 'responsetemplate', get_string('responsetemplate', 'qtype_qportugol'),
                array('rows' => 10),  array_merge($this->editoroptions, array('maxfiles' => 0)));

        $mform->addHelpButton('responsetemplate', 'responsetemplate', 'qtype_qportugol');

        $mform->addElement('header', 'graderinfoheader', get_string('graderinfoheader', 'qtype_qportugol'));
        $mform->setExpanded('graderinfoheader') ;
        $mform->addElement('editor', 'graderinfo', get_string('graderinfo', 'qtype_qportugol'),
                array('rows' => 10), $this->editoroptions);

    }

    protected function data_preprocessing($question) {
        $question = parent::data_preprocessing($question);

        if (empty($question->options)) {
            return $question;
        }

        $draftid = file_get_submitted_draft_itemid('graderinfo');
        $question->graderinfo = array();
        $question->graderinfo['text'] = file_prepare_draft_area(
            $draftid,           // Draftid
            $this->context->id, // context
            'qtype_qportugol',      // component
            'graderinfo',       // filarea
            !empty($question->id) ? (int) $question->id : null, // itemid
            $this->fileoptions, // options
            $question->options->graderinfo // text.
        );
        $question->graderinfo['format'] = $question->options->graderinfoformat;
        $question->graderinfo['itemid'] = $draftid;

        $question->responsetemplate = $question->options->responsetemplate;

        return $question;
    }

    public function validation($fromform, $files) {
        $errors = parent::validation($fromform, $files);

        // Don't allow both 'no inline response' and 'no attachments' to be selected,
        // as these options would result in there being no input requested from the user.
        if ($fromform['responseformat'] == 'noinline' && !$fromform['attachments']) {
            $errors['attachments'] = get_string('mustattach', 'qtype_qportugol');
        }

        // If 'no inline response' is set, force the teacher to require attachments;
        // otherwise there will be nothing to grade.
        if ($fromform['responseformat'] == 'noinline' && !$fromform['attachmentsrequired']) {
            $errors['attachmentsrequired'] = get_string('mustrequire', 'qtype_qportugol');
        }

        // Don't allow the teacher to require more attachments than they allow; as this would
        // create a condition that it's impossible for the student to meet.
        if ($fromform['attachments'] != -1 && $fromform['attachments'] < $fromform['attachmentsrequired'] ) {
            $errors['attachmentsrequired']  = get_string('mustrequirefewer', 'qtype_qportugol');
        }

        return $errors;
    }

    public function qtype() {
        return 'qportugol';
    }
}
