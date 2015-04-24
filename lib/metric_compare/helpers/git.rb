module Git
  def self.head
    commit_hash_for_step
  end
  
  def self.last_commit
    commit_hash_for_step 1
  end
    
  # give me the hash for this step(0=current HEAD)
  def self.commit_hash_for_step(step=0)
    `git rev-parse HEAD~#{step}`.strip    
  end
end