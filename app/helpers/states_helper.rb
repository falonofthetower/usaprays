module StatesHelper

  def leader_data_tr(leader_field, leader_label)
    unless leader_field.blank?
      str =  "<tr>"
      str += "<th>#{leader_label}</th>"
      str += "<td>#{leader_field}</td>"
      str += "</tr>"
      str.html_safe
    end
  end
end
