# Copyright © 2012 The Pennsylvania State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
class GenericFile < ActiveFedora::Base
  include Sufia::GenericFile

  has_metadata :name => "properties", :type => ExtendedPropertiesDatastream

  delegate_to :properties, [:tags]

  attr_accessible *(ds_specs['descMetadata'][:type].fields +  [:tags, :permissions])


  def to_solr(solr_doc={}, opts={})
    super(solr_doc, opts)

    if(self.properties.tags.count > 0)
      tagsArray = self.properties
                      .tags
                      .flatten
                      .join(" ")
                      .gsub(","," ")
                      .split

      solr_doc[Solrizer.solr_name('fields_tags', :facetable)] = tagsArray
      solr_doc[Solrizer.solr_name('fields_tags')] = tagsArray
    end


    return solr_doc
  end


  #this overrides web_form.rb method
  def terms_for_display
    # 'type' is the RDF.type assertion, which is not present by default, but may be
    # provided in some RDF schemas
    self.descMetadata.class.fields + [:tags] - [:tag]
  end
end
