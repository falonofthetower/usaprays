class MailChimp

  def list_id
    ENV['MC_LIST_ID']
  end

  def segments
    mc('list_static_segments') 
  end

  def members
    mc('list_members')
  end

  def create_segment(name)
    mc('list_static_segment_add', name: name)
  end

  def delete_segment(name)
    mc('list_static_segment_del', seg_id: id_of_segment(name))
  end

  def segment_members(name)
  end

  def subscribe(email, merge_vars)
    mc('list_subscribe', {
      email_address: email,
      merge_vars: merge_vars,
      double_optin: false,
      update_existing: true,
      send_welcome: true
      })
  end

  def add_to_segment(email, seg_name)
    mc('list_static_segment_members_add', 
       seg_id: id_of_segment(seg_name),
       batch: [email]
      )
  end

  def subscribe_to_segment(email, seg_name, merge_vars)
    subscribe(email, merge_vars)
    add_to_segment(email, seg_name)
  end

  private
    def mc(message, args={})
      Gibbon.new.send(message, {id: list_id}.merge(args))
    end

    def id_of_segment(name)
      name_ids = {}
      segments.each do |s|
        name_ids[s['name']] = s['id']
      end
      name_ids[name]
    end
end
